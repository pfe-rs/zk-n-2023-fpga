#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>

int main()
{
	mkfifo("pipe", 0600);
	/*if(fork() == 0)
	{
		system("mono bin/Debug/projekatUART.exe");
	}*/
	//int fd = open("pipe", O_WRONLY);
	int fd = -1;
	int port = open("/dev/ttyUSB0", O_RDONLY);
	char c;
	bool cs;
	
	struct pollfd fds;
	fds.fd = port;
	fds.events = POLLIN;
	while(1)
	{
		poll(&fds, 1, -1);
		read(port, &c, 1);
		int k = c;
		printf("%i\n", k);
		fflush(stdout);
		if(c == 20)
		{
			if(fork() == 0)
			{
				system("aplay Pesme/Despacito.wav");
			}
		}
		else
		{
			write(fd, &c, 1);
		}
	}
	
	close(fd);
	close(port);	
	unlink("pipe");
	return 0;
}
