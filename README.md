## GOV.UK Content Best Practices

This repository hosts snapshots of gov.uk pages acting as examples of pages using content best practices.

## Adding new pages manually

- Navigate to the [/snapshots dir](https://github.com/alphagov/govuk-content-best-practices/tree/master/snapshots) and create a new file, [here's how](https://help.github.com/articles/creating-new-files/)
- The new file name should be `<words-separated-with-hyphens>.html` eg `example-content.html`
- Paste the contents of [the template file](/template.html) there.
- Open the original page that you want to take a snapshot of and copy either `<div id='whitehall-wrapper'>` or `<div id='whitehall-wrapper'>` tag with its contents. You can do it by finding those elements via [developer tools](https://developer.chrome.com/devtools).
- Replace `<div id="placeholder">REPLACE THIS WHOLE DIV WITH PASTED CONTENT</div>` with everything you've copied in the step above.
- Open a pull request with the new file explaining the changes
- Someone will review the changes and merge them to the `gh-pages` branch, which will make the new page available at http://alphagov.github.io/govuk-content-best-practices/snapshots/{your-file-name}.html

## Adding new pages automatically

- Update the list of links in [exec/crawl.rb](/exec/crawl.rb)
- run `ruby exec/crawl.rb`

Alternatively you can use the `Crawler` class in ruby:

```
Crawler.new(["https://gov.uk/something"], persist_to: '/tmp').run
```
