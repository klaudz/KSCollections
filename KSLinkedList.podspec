
Pod::Spec.new do |s|

  s.name          = 'KSLinkedList'
  s.version       = '1.0.0'
  s.summary       = 'KSLinkedList'
  s.description   = <<-DESC
                    KSLinkedList
                    DESC
  s.homepage      = 'https://github.com/klaudz/KSLinkedList'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.authors       = { 'klaudz' => 'klaudzliang@gmail.com' }

  s.ios.deployment_target = '8.0'

  s.source        = { :git => 'https://github.com/klaudz/KSLinkedList.git', :tag => s.version.to_s }
  s.source_files  = 'KSLinkedList/**/*.{h,m,mm}'
  s.public_header_files = 'KSLinkedList/*.h'
  s.requires_arc  = false
  
  s.frameworks    = 'Foundation'

end
