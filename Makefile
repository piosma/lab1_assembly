# Nazwa pliku wynikowego
OUTPUT = program1

# Kompilator asemblera
AS = gcc
ASFLAGS = -m32 

# Pliki źródłowe
SRC = program1.s
OBJ = program1.o

# Reguła domyślna - kompiluje cały program
all: $(OUTPUT)

# Kompilacja asemblera do pliku obiektowego
$(OBJ): $(SRC)
	$(AS) $(ASFLAGS) -c $(SRC) -o $(OBJ)

# Linkowanie pliku obiektowego do programu wykonywalnego
$(OUTPUT): $(OBJ)
	$(AS) $(ASFLAGS) $(OBJ) -o $(OUTPUT) -no-pie

# Usuwanie plików tymczasowych
clean:
	rm -f $(OBJ) $(OUTPUT)

test: all
	./run_tests.sh

