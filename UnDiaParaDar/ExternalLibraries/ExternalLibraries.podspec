# 

Pod::Spec.new do |s|
  s.name             = "ExternalLibraries"
  s.version          = "0.1.0"
  s.summary          = "All the libraries that aren't in a Pod already"
  s.description      = <<-DESC
                       DESC
  s.license          = 'MIT'
  s.author           = { "Facundo Menzella" => "facumenzella@gmail.com" }

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = '**/*.{m,h}'
  s.requires_arc = true

  s.public_header_files = '**/*.h'
  s.frameworks = 'UIKit'
end


