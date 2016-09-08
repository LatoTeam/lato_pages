module LatoPages
  module Interface

    require 'lato_pages/interface/languages'
    include LatoPages::Interface::Languages

    require 'lato_pages/interface/config'
    include LatoPages::Interface::Config

    require 'lato_pages/interface/template'
    include LatoPages::Interface::Template

  end
end
