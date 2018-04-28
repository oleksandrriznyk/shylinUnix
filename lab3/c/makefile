.PHONY: all clean install uninstall

app: app.o lan.o
	$(CC) -std=c99 -o app app.o lan.o


app.o: app.c defs.h
	$(CC) -std=c99 -c app.c

lan.o: lan.c defs.h
	$(CC) -std=c99 -c lan.c


clean:
	rm app app.o lan.o

install:
	install ./app /usr/local/bin

uninstall:
	rm -rf /usr/local/bin/app
