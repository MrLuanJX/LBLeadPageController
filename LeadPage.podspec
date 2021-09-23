Pod::Spec.new do |s|
  s.name             = 'LeadPage'
  s.version          = '0.1.2'
  s.summary          = '理享学新手引导页组件'

  s.homepage         = 'http://10.10.11.11/luanjinxin/LBLeadPage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luanjinxin' => '22392372@qq.com' }
  s.source           = { :git => 'git@10.10.11.11:luanjinxin/LBLeadPage.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = "LBLeadPageController/LBLeadPageFiles/*.{h,m}"
  s.resources    = "LBLeadPageController/LBLeadPageFiles/images.bundle"
  s.frameworks = "Foundation","UIKit"
  s.requires_arc = true

end
