
[1mFrom:[0m /mnt/c/Users/pclan/desktop/softwareengineering/ruby/flatiron/oo-student-scraper-onl01-seng-pt-120819/lib/scraper.rb @ line 32 Scraper.scrape_profile_page:

    [1;34m20[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m21[0m:   html = open(profile_url)
    [1;34m22[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m23[0m:   hashyhash = []
    [1;34m24[0m:   x = doc.css([31m[1;31m'[0m[31m.profile .vitals-container .social-icon-container a[1;31m'[0m[31m[0m)
    [1;34m25[0m: 
    [1;34m26[0m:   x.each [32mdo[0m |y|
    [1;34m27[0m:     [1;34m# puts y.attr('href')[0m
    [1;34m28[0m:     hashyhash << { [33m:twitter[0m => y.attr([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m) }
    [1;34m29[0m:     hashyhash << { [33m:linkedin[0m => y.attr([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m) }
    [1;34m30[0m:     hashyhash << { [33m:github[0m => y.attr([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m) }
    [1;34m31[0m:     hashyhash << { [33m:blog[0m => y.attr([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m) }
 => [1;34m32[0m:     binding.pry
    [1;34m33[0m:   [32mend[0m
    [1;34m34[0m:   [1;34m# binding.pry[0m
    [1;34m35[0m:   [1;34m# x.attr('href').value == twitter[0m
    [1;34m36[0m: [32mend[0m

