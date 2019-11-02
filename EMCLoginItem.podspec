Pod::Spec.new do |s|
  s.name         = "EMCLoginItem"
  s.version      = "1.0.2"
  s.summary      = "EMCLoginItem is an Objective-C library to query, add and remove login items in Apple OS X."
  s.description  = <<-DESC
                   `EMCLoginItem` is an Objective-C library to query, add and remove login items
                   in Apple OS X.
                   DESC
  s.homepage     = "https://github.com/emcrisostomo/EMCLoginItem"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "Enrico M. Crisostomo" => "http://thegreyblog.blogspot.com/" }
  s.social_media_url   = "http://thegreyblog.blogspot.com"
  s.platform     = :osx
  s.source       = { :git => "https://github.com/emcrisostomo/EMCLoginItem.git", :tag => "1.0.2" }
  s.source_files  = "EMCLoginItem", "EMCLoginItem/**/*.{h,m}"
  s.exclude_files = "EMCLoginItem/Exclude"
  s.requires_arc = true
end
