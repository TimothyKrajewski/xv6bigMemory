#include "types.h"
#include "user.h"

#define MAXPATH 512

int main(int argc, char* argv[])
{
	char path[MAXPATH];
	getcwd(path, MAXPATH);
	printf(0, "%s\n", path);
	exit();
}
