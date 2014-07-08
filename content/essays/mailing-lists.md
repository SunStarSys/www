Title: Mailing Lists

## ezmlm-idx

My experience with mailing list software revolves around `qmail` and `ezmlm-idx`.
With a few small scripts, I was able to support a wide variety of new use cases
not inherently supported by `ezmlm-idx` itself.  The features that are generically
useful outside of [The Apache Software Foundation](http://www.apache.org) are
laid out below.  To use these files follow this [layout](files/) unless you
are comfortable adjusting the paths in the scripts yourself.


### BATV and SRS

[sender-demunger](files/bin/sender-demunger) is a little wrapper script that
enables `BATV` and `SRS` `SENDER` demunging for `ezmlm-idx`.  To use it you simply
add it as a prefix to all of the lines in your `</editor/>` block within `.ezmlmrc` and
run `ezmlm-make -+` on your lists, or in a pinch assuming you will not run `ezmlm-make`
again on your lists, edit the `editor` file within your list directories.

### DMARC

See [ezmlm-dmarc-filter](files/bin/ezmlm-dmarc-filter) and
[ezmlm-seekable-stdin](files/bin/ezmlm-seekable-stdin) and
[pull_header](files/lib/pull_header.pm).  To use these scripts,
change the lines in your `</editor/>` section of `.ezmlmrc` that
call `ezmlm-gate`, `ezmlm-store`, or `ezmlm-send`, to look like the following:

    |/path/to/bin/ezmlm-dmarc-filter '<#D#>/dmarc' | /path/to/bin/ezmlm-seekable-stdin /path/to/bin/sender-demunger <#B#>/ezmlm-gate -rY '<#D#>' '<#D#>' '<#D#>/digest' '<#D#>/allow' '<#D#>/mod'
    |/path/to/bin/ezmlm-dmarc-filter '<#D#>/dmarc' | /path/to/bin/sender-demunger <#B#>/ezmlm-store '<#D#>'
    |/path/to/bin/ezmlm-dmarc-filter '<#D#>/dmarc' | <#B#>/ezmlm-send -r '<#D#>'


This assumes you will touch a file named `dmarc` in any list directories where you want
to enable the filter.  You can configure `.ezmlmrc` to do this by adding the following block
to that file:

    </-dmarc#FXT/>
    </dmarc#f/>
    </dmarc#t/>
    </dmarc#x/>

The only list configurations that run afoul of DMARC are those with `-f`, `-t` or `-x` set.
The above configuration will adjust for that.

$Date$
