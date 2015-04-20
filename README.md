# Open in Paw (JavaScript API)

## Use

```html
<script type="text/javascript">
(function(){
  var aclk = function(e) {
    var op = function(){
      // paw.open({'deeplink':e.target.href});
      paw.open({'a':e.target});
    };
    if (typeof paw === 'undefined') {
      (function() {
        var sc = document.createElement('script');
        sc.type = 'text/javascript';
        sc.async = true;
        sc.src = 'https://d3prvxvd1wsnnz.cloudfront.net/js/paw.api.js';
        sc.onload = op;
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(sc, s);
      })();
    }
    else {
      op();
    }
    e.preventDefault();
  };
  var as = document.getElementsByTagName("A");
  for (var i=0; i<as.length; i++) {
    var href = as[i].href;
    if (href && 0 === href.indexOf('paw://')) {
      as[i].addEventListener('click', aclk);
    }
  }
})();
</script>
```

## Development

### Build

```shell
gulp
```

### Watch

```shell
gulp watch
```

### Hosting

Hosted on Github Pages. See: [Creating Project Pages manually](https://help.github.com/articles/creating-project-pages-manually/)
