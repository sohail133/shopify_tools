# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/lib", under: "lib"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@4.3.1/dist/js/bootstrap.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.0/dist/jquery.js"
pin "popper.js", to: "https://ga.jspm.io/npm:popper.js@1.16.1/dist/umd/popper.js"
pin "themes/vendors.min"
pin "themes/jquery.sticky"
pin "themes/apexcharts.min"
pin "themes/tether.min"
pin "themes/shepherd.min"
pin "themes/app-menu.min"
pin "themes/app"
pin "themes/components.min"
pin "themes/dashboard-analytics.min"
