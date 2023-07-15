BIN           = ~/GitHub/cc65/bin/cl65
OBJDIR        = ./Objects
SRCDIR        = ./Source

all:
	mkdir -p $(OBJDIR)/
	$(BIN) -C $(SRCDIR)/PharaohsCurse.cfg $(SRCDIR)/PharaohsCurse.s -v --start-addr 0x0480 -Ln $(OBJDIR)/object.vs -o $(OBJDIR)/object.prg
	./build_atr.py

clean:
	rm -rf $(OBJDIR)/
