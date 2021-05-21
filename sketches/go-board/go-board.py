print("Hello!");
print(modules);

ModulePath = "../../modules";
ModuleFiles = [];

for m in modules:
	ModuleFiles += [ModulePath + "/" + m + "/" + m + '.v'];
	print(ModulePath + "/" + m + "/" + m + '.v');

print(ModuleFiles);
