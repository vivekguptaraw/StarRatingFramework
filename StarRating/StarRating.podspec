Pod::Spec.new do |s|
          #1.
          s.name               = "StarRating"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Easy to use Star Rating Control with smooth draggable feature and floating point rating can be easily selected with dragging movement"
          #4.
          s.homepage        = "http://www.mobileformobile.com"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Vivek gupta"
          #7.
          s.platform     = :ios, '9.0'
          #8.
          #s.source              = { :git => "git@github.com:vivekguptaraw/StarRatingFramework.git" }
	  s.source       = { :path => '.' }
          #9.
          s.source_files 	= '*.{swift,xib,h}'
end  
