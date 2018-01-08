Pod::Spec.new do |s|
  s.name             = "TKFMWK"
  s.version          = "2.2.0"
  s.summary          = "Just Testing."
  s.description      = <<-DESC
                       Testing Private Podspec.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://192.168.1.67/Louis/podSpec"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "wtlucky" => "wtlucky@foxmail.com" }
  s.source           = { :git => "http://192.168.1.67/Louis/777777.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'TKFMWK/THFMWK/**/*','TKFMWK/THFMWK/util/crypto/OpensslSDK/include/**/*'
# 配置的就是我们的framework 和 library
  s.frameworks   = 'UIKit', 'Foundation', 'AVFoundation','CoreMedia','CoreVideo'
  s.library = 'sqlite3.0', 'libz.1.2.5','libc++','libiconv'

  s.compiler_flags = '-DSQLITE_HAS_CODEC'

  s.prefix_header_file = 'TKFMWKPrefix.pch'
  s.vendored_framework = 'TKFMWK/TKAppBase_V2.framework','TKFMWK/THFMWK/appbase/UMengSDK/UMMobClick.framework'
  s.resources = 'TKFMWK/TKAsset.bundle'

  s.xcconfig = {"FRAMEWORK_SEARCH_PATHS"=>"$(PROJECT_DIR)/TKFMWK/THFMWK/util/crypto/OpensslSDK/include/", "OTHER_CFLAGS"=>"-DSQLITE_HAS_CODEC"}


# 指定指定预编译的配置
  s.prefix_header_contents = <<-EOS
  #ifdef __OBJC__
  #import <UIKit/UIKit.h>
  #import <Foundation/Foundation.h>
  #import <TKAppBase_V2/TKAppBase.h>
  #endif /* __OBJC__*/
  EOS

end