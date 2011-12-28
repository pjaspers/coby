Pod::Spec.new do |s|
  s.name     = 'coby'
  s.version  = '0.0.1'
  s.summary  = 'Opinionated categories for Objective C'
  s.homepage = 'https://github.com/pjaspers/Tin'
  s.author   = { 'pjaspers' => 'piet@jaspe.rs' }

  s.source   = { :git => 'https://github.com/pjaspers/coby.git' }

  s.description = 'Opinionated categories on default objc-classes.'

  s.source_files = "*.{h,m}"
end
