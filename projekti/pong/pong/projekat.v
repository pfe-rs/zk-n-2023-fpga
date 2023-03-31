

// ############
// pong samo sa inbuilt tasterima reworkovan unazad iz pong_tastatura, ne testirano *ali* bi trebalo da radi 
// ############

module projekat(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//  GPIO za matrix
	output			  [15:0]		GPIO_0
	// preskacemo 9
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [32:0] sekunda;

//=======================================================
//  Structural coding
//=======================================================

	wire [7:0] r;
	wire [7:0] k;
	
	//redovi, pozitivni, mozda increment
	assign GPIO_0[8]  = r[0];
	assign GPIO_0[13] = r[1];
	assign GPIO_0[7]  = r[2];
	assign GPIO_0[11] = r[3];
	assign GPIO_0[0]  = r[4];
	assign GPIO_0[6]  = r[5];
	assign GPIO_0[1]  = r[6];
	assign GPIO_0[4]  = r[7];

	
	// kolone, negativne;
	assign GPIO_0[12] = k[0];
	assign GPIO_0[2]  = k[1];
	assign GPIO_0[3]  = k[2];
	assign GPIO_0[9]  = k[3];
	assign GPIO_0[5]  = k[4];
	assign GPIO_0[10] = k[5];
	assign GPIO_0[14] = k[6];
	assign GPIO_0[15] = k[7];
	
		

	wire [15:0] sve;
	wire [3:0] x;
	wire [3:0] y;
	wire [3:0] pom1;
	wire [3:0] pom2;
	wire [3:0] smer;
	wire [3:0] poeni1;
	wire [3:0] poeni2;

	wire [3:0] x_b,y_b;
	wire [3:0] game;
	wire [3:0] game2;
	
	assign r = sve[15:8];
	assign k = sve[7:0];
	wire first;
	one_sec sek(CLOCK_50, sekunda);
	multipleks mp(CLOCK_50, sve[15:0], x,y); // multipleksiranje izlaza na displej 
	
	keys dugmici(sekunda, pom1, pom2, KEY[3:0], game, first, game2); // key handler za dugmice koji kontrolisu
	rand rnd(CLOCK_50,KEY[0],smer); // lfsr za nasumican pocetni smer, moguce su samo dve opcije posto ukoliko lopta krene ukoso moze da dovede odma do deadlock situacije gde lopta samo odskace iz coska u cosak
	
	ball bl(sekunda, smer, x_b, y_b, pom1, pom2, poeni1, poeni2, game, first, game2);
	red_sweep rd(CLOCK_50, pom1, pom2, x, y, x_b, y_b);

	// sedmo-segmentni displeji za ispis poena i oznacavanje pobednika/gubitnika
	hex hex1(poeni1, HEX0[6:0]);
   hex hex2(poeni2,  HEX5[6:0]);

endmodule
