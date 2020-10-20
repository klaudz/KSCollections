
Pod::Spec.new do |s|

  s.name          = 'KSCollections'
  s.version       = '1.0.0'
  s.summary       = 'KSCollections'
  s.description   = <<-DESC
                    KSCollections
                    DESC
  s.homepage      = 'https://github.com/klaudz/KSCollections'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.authors       = { 'klaudz' => 'klaudzliang@gmail.com' }

  s.ios.deployment_target = '8.0'

  s.source        = { :git => 'https://github.com/klaudz/KSCollections.git', :tag => s.version.to_s }
  s.source_files  = 'KSCollections/**/*.{h,m,mm}'
  s.public_header_files = 'KSCollections/**/*.h'
  s.requires_arc  = false
  
  s.frameworks    = 'Foundation'

end
