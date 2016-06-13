include LatoCore::Interface
include LatoPages::Interface

# IMPOSTAZIONE FILE DI LINGUA

PAGES_LANG = core_loadModuleLanguages('lato_pages')

# SCARICO I DATI DELLE PAGINE SALVATI NELLA CACHE E LI CARICO NEL DATABASE

if(LatoPages::Page.table_exists? and  LatoPages::Field.table_exists?)
    pages_syncConfigLanguages()
    pages_syncConfigFile()
end
