.SUFFIXES: .cfg .dot .svg .png

DOT	= /opt/local/bin/dot
DOTOPTS	=

.cfg.dot:
	./rfcdeps $(DEPOPTS) $< > $@

.dot.svg:
	$(DOT) $(DOTOPTS) -Tsvg -o $@ $<

.dot.png:
	$(DOT) $(DOTOPTS) -Tpng -o $@ $<

TARGETS = dnsproto.svg dnsrr.svg dnsop.svg enum.svg	\
	  smtp.svg imap.svg pop.svg dkim.svg idna.svg	\
	  ospf.svg bgp4.svg				\
	  ipv6.svg 					\
	  sip.svg rtp.svg				\
	  ntp.svg					\
	  rfcs.svg rfcs-sub.svg

all:	$(TARGETS)

rfcs-sub.dot:	rfcs.cfg
	./rfcdeps --title "RFC Dependencies (no standalone docs)" --no-orphans $< > $@

fetch:
	$(RM) rfc-index.xml
	wget ftp://ftp.rfc-editor.org/in-notes/rfc-index.xml

clean:
	$(RM) *.svg *.dot
