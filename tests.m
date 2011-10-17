//
//  main.m
//  MACollectionUtilities
//
//  Heavily borrowed from [Micheal Ash's simple test harness](https://raw.github.com/mikeash/MACollectionUtilities/master/main.m)
//

#import <Foundation/Foundation.h>
#import "Coby.h"

// # Tests setup
static void WithPool(void (^block)(void))
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    block();
    [pool release];
}

static int gFailureCount;

static void Test(void (*func)(void), const char *name)
{
    WithPool(^{
        int failureCount = gFailureCount;
        NSLog(@"Testing %s", name);
        func();
        NSLog(@"\t %s", failureCount == gFailureCount ? "SUCCESS" : "FAILED");
    });
}

#define TEST(func) Test(func, #func)

#define TEST_ASSERT(cond, ...) do { \
        if(!(cond)) { \
            gFailureCount++; \
            NSString *message = [NSString stringWithFormat: @"" __VA_ARGS__]; \
            NSLog(@"%s:%d: assertion failed: %s %@", __func__, __LINE__, #cond, message); \
        } \
    } while(0)


// # The actual tests

static void test_nsarray_from_returns_empty_array_when_too_big(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
  TEST_ASSERT([[anArray from:3] isEqual:[NSArray array]]);
}

static void test_nsarray_from_returns_correct_result(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
  NSArray *shouldBe = [NSArray arrayWithObjects:@"Two", @"Three", nil];
  TEST_ASSERT([[anArray from:1] isEqual:shouldBe]);
}

static void test_nsarray_to_returns_empty_array_on_empty_array(void)
{
  NSArray *anArray = [NSArray array];
  NSArray *shouldBe = [NSArray array];
  TEST_ASSERT([[anArray to:1] isEqual:shouldBe]);
}

static void test_nsarray_to_returns_array_with_too_large_argument(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", nil];
  NSArray *shouldBe = [NSArray arrayWithObjects:@"One", @"Two", nil];
  NSString *message = [NSString stringWithFormat:@"%@ == %@", [anArray to:5], shouldBe];
  TEST_ASSERT([[anArray to:5] isEqual:shouldBe]);
}

static void test_nsarray_to_returns_correct_result(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
  NSArray *shouldBe = [NSArray arrayWithObjects:@"One", @"Two", nil];
  TEST_ASSERT([[anArray to:1] isEqual:shouldBe]);
}

static void test_cb_safe_object_at_index_with_correct_index(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
  TEST_ASSERT([[anArray CB_safeObjectAtIndex:0] isEqual:@"One"]);
}

static void test_cb_safe_object_at_index_with_wrong_index_returns_nil(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
  TEST_ASSERT([anArray CB_safeObjectAtIndex:4] == nil);
}

// # The test run loop

int main(int argc, char **argv)
{
    WithPool(^{
        NSLog(@"NSArray - Accessors");
        NSLog(@"---------------------------------------------------------------------------");
        TEST(test_nsarray_from_returns_empty_array_when_too_big);
        TEST(test_nsarray_from_returns_correct_result);
        TEST(test_nsarray_to_returns_correct_result);
        TEST(test_nsarray_to_returns_empty_array_on_empty_array);
        TEST(test_nsarray_to_returns_array_with_too_large_argument);
        TEST(test_cb_safe_object_at_index_with_wrong_index_returns_nil);
        TEST(test_cb_safe_object_at_index_with_correct_index);
        NSLog(@"---------------------------------------------------------------------------");
        NSString *message;
        if(gFailureCount)
            message = [NSString stringWithFormat: @"FAILED: %d total assertion failure%s", gFailureCount, gFailureCount > 1 ? "s" : ""];
        else
            message = @"SUCCESS";
        NSLog(@"Tests complete: %@", message);
    });
    return 0;
}