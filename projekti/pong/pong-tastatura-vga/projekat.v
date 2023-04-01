




//	
	// pong stvari
		wire [7:0] redovi_pong;
	wire [7:0] kolone_pong;
	
	//redovi, pozitivni, mozda increment
	assign GPIO_0[8]  = redovi_pong[0];
	assign GPIO_0[13] = redovi_pong[1];
	assign GPIO_0[7]  = redovi_pong[2];
	assign GPIO_0[11] = redovi_pong[3];
	assign GPIO_0[0]  = redovi_pong[4];
	assign GPIO_0[6]  = redovi_pong[5];
	assign GPIO_0[1]  = redovi_pong[6];
	assign GPIO_0[4]  = redovi_pong[7];

	
	// kolone, negativne;
	assign GPIO_0[12] = kolone_pong[0];
	assign GPIO_0[2]  = kolone_pong[1];
	assign GPIO_0[3]  = kolone_pong[2];
	assign GPIO_0[9]  = kolone_pong[3];
	assign GPIO_0[5]  = kolone_pong[4];
	assign GPIO_0[10] = kolone_pong[5];
	assign GPIO_0[14] = kolone_pong[6];
	assign GPIO_0[15] = kolone_pong[7];
	
	wire [15:0] sve;
	wire [3:0] x;
	wire [3:0] y;
	wire [3:0] pom1;
	wire [3:0] pom2;
	wire [3:0] smer;
	wire [3:0] poeni1;
	wire [3:0] poeni2;

	//assign y = 0; // prva kolona samo
	wire [3:0] x_b,y_b;
	wire [3:0] game;
	wire [3:0] game2;
	
	// tastatura
	wire [123:0] keyreg;
	wire [7:0] buttons;
	
	assign redovi = sve[15:8];
	assign kolone = sve[7:0];
	wire first;
	// kraj pong stvari
	wire [32:0] sekunda;
//




	one_sec sek(CLOCK_50, sekunda);
	multipleks mp(CLOCK_50, sve[15:0], x,y);
	ps2parse tastature(PS2_CLK, PS2_DAT, buttons, keyreg);
	keys dugmici(sekunda,pom1,pom2,buttons,game,first,game2);
	rand rnd(CLOCK_50,KEY[0],smer);
	ball bl(sekunda,smer,x_b,y_b,pom1,pom2,poeni1,poeni2,game,first,game2);
	red_sweep rd(CLOCK_50,pom1,pom2,x,y,x_b,y_b);

	hex hex1(poeni1, HEX0[6:0]);
   hex hex2(poeni2,  HEX5[6:0]);
	