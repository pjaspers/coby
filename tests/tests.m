//
//  tests.m
//  Coby
//
//  Heavily borrowed from [Micheal Ash's simple test harness](https://raw.github.com/mikeash/MACollectionUtilities/master/main.m)
//

#import <Foundation/Foundation.h>
#import "../Coby.h"

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

static void test_nsarray_manipulations(void)
{
  NSArray *anArray = [NSArray arrayWithObjects:@"1", @"Two", @"3", @"Four",nil];
  NSArray *partitioned = [anArray partition:^BOOL (id obj){
      if ([obj length] > 1) return YES;
      return NO;
    }];
  NSArray *partitionedShouldBe = [NSArray arrayWithObjects:
                                            [NSArray arrayWithObjects:@"Two", @"Four", nil],
                                          [NSArray arrayWithObjects:@"1", @"3", nil], nil];
  TEST_ASSERT([partitionedShouldBe isEqual:partitionedShouldBe]);

  BOOL anyHasLengthOfZero = [anArray any:^BOOL (id obj){ return [obj length] == 0;}];
  BOOL anyHasLengthOfOne = [anArray any:^BOOL (id obj){ return [obj length] == 1;}];
  TEST_ASSERT(anyHasLengthOfOne);
  TEST_ASSERT(!anyHasLengthOfZero);

  TEST_ASSERT([[anArray first] isEqual:[anArray detect:^BOOL (id obj){ return [obj length] == 1 ;}]]);

  NSArray *firstTwoElements = [NSArray arrayWithObjects:@"1", @"Two", nil];
  TEST_ASSERT([[anArray take:2] isEqual:firstTwoElements]);
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

static void test_nsdict_fetch_with_block_missing_key(void)
{
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Steve",@"name", nil];
  NSString *shouldBe = @"Looked for: title";
  NSString *result = [dict fetch:@"title" withBlock:^id(id obj) {
      return [NSString stringWithFormat:@"Looked for: %@", obj];
    }];
  TEST_ASSERT([result isEqualToString:shouldBe]);
}

static void test_nsdict_fetch_with_block(void)
{
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Steve",@"name", nil];
  NSString *shouldBe = @"Looked for: Steve";
  NSString *result = [dict fetch:@"name" withBlock:^id(id obj) {
      return [NSString stringWithFormat:@"Looked for: %@", obj];
    }];
  TEST_ASSERT([result isEqualToString:shouldBe]);
}

static void test_nsdict_merge(void)
{
  NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"a value", @"a", @"b value", @"b",nil];
  NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"c value", @"c", @"newer value", @"b",nil];
  NSDictionary *shouldBe = [NSDictionary dictionaryWithObjectsAndKeys:@"a value", @"a", @"newer value", @"b", @"c value", @"c", nil];
  NSDictionary *result = [dict1 merge:dict2];

  TEST_ASSERT([result isEqual:shouldBe]);
}

static void test_nsdict_merge_with_block(void)
{
  NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"a value", @"a", @"b value", @"b",nil];
  NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"c value", @"c", @"newer value", @"b",nil];
  NSDictionary *shouldBe = [NSDictionary dictionaryWithObjectsAndKeys:@"a value", @"a", @"b value - newer value", @"b", @"c value", @"c", nil];


  NSDictionary *result = [dict1 merge:dict2 withBlock:^(NSString *key, id oldValue, id newValue){
      return [NSString stringWithFormat:@"%@ - %@", oldValue, newValue];
    }];
  TEST_ASSERT([result isEqual:shouldBe]);
}

static void test_nsstring_center(void)
{
  NSString *toBePadded = @"Coby";
  NSString *shouldBe = @"        Coby        ";
  NSString *shouldBeWithPadding = @"________Coby________";

  NSString *shortResult = [toBePadded center:1];
  NSString *result = [toBePadded center:20];
  NSString *resultWithPadding = [toBePadded center:20 withPaddedString:@"_"];
  TEST_ASSERT([shortResult isEqualToString:toBePadded]);
  TEST_ASSERT([result isEqualToString:shouldBe]);
  TEST_ASSERT([resultWithPadding isEqualToString:shouldBeWithPadding]);
  TEST_ASSERT([[@"a" center:4] isEqualToString:@" a  "]);
}

static void test_nsstring_index(void)
{
  NSString *searchString = @"Coby yboC";
  TEST_ASSERT([searchString index:@"C"] == 0);
  TEST_ASSERT([searchString index:@"D"] == -1);
  TEST_ASSERT([searchString index:@"by"] == 2);

  TEST_ASSERT([searchString index:@"C" startingAt:4] == 8);
  TEST_ASSERT([searchString index:@"C" startingAt:20] == -1);
}

static void test_nsstring_reverse(void)
{
  TEST_ASSERT([[@"Coby" reverse] isEqualToString:@"yboC"]);
  TEST_ASSERT([[@"Côby" reverse] isEqualToString:@"ybôC"]);
}

static void test_nsobject(void)
{
  NSArray *testArray = [NSArray arrayWithObjects:@"A",@"B", @"C", nil];
  TEST_ASSERT([[testArray send:@"lastObject"] isEqualTo:[testArray lastObject]]);
  TEST_ASSERT([[testArray try:@"lastObject"] isEqualTo:[testArray lastObject]]);
  TEST_ASSERT([[testArray try:@"something" default:@"bla"] isEqualTo:@"bla"]);
  NSMutableArray *s = [[NSMutableArray array] tap:^void(id obj){
      [obj addObject:@"A"];
    }];
  TEST_ASSERT([[NSArray arrayWithArray:s] isEqualTo:[NSArray arrayWithObject:@"A"]]);
}

// # The test run loop

int main(int argc, char **argv)
{
    WithPool(^{
        NSLog(@"NSArray");
        NSLog(@"----------------------------------");
        NSLog(@" - Accessors");
        TEST(test_nsarray_from_returns_empty_array_when_too_big);
        TEST(test_nsarray_from_returns_correct_result);
        TEST(test_nsarray_to_returns_correct_result);
        TEST(test_nsarray_to_returns_empty_array_on_empty_array);
        TEST(test_nsarray_to_returns_array_with_too_large_argument);
        TEST(test_nsarray_manipulations);
        TEST(test_cb_safe_object_at_index_with_wrong_index_returns_nil);
        TEST(test_cb_safe_object_at_index_with_correct_index);
        NSLog(@" - Higher Level Functions");

        NSLog(@"----------------------------------");
        NSLog(@"NSDictionary");
        NSLog(@"----------------------------------");
        TEST(test_nsdict_fetch_with_block);
        TEST(test_nsdict_fetch_with_block_missing_key);
        TEST(test_nsdict_merge);
        TEST(test_nsdict_merge_with_block);
        NSLog(@"----------------------------------");
        NSLog(@"NSString");
        NSLog(@"----------------------------------");
        TEST(test_nsstring_center);
        TEST(test_nsstring_index);
        TEST(test_nsstring_reverse);
        NSLog(@"----------------------------------");
        NSLog(@"NSObject");
        NSLog(@"----------------------------------");
        TEST(test_nsobject);
        NSString *message;
        if(gFailureCount)
            message = [NSString stringWithFormat: @"FAILED: %d total assertion failure%s", gFailureCount, gFailureCount > 1 ? "s" : ""];
        else
            message = @"SUCCESS";

        NSLog(@"###################################");
        NSLog(@"Tests complete: %@", message);
    });
    return 0;
}
