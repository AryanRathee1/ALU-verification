`timescale 1ns / 1ps

module alu_assign(
    A,      // 
    B,      //
    CLK,    //
    RST,    //
    MODE,   //
    CMD,    //
    RES,    //
    Flag    //    
    );
    
    //Input output port declaration
  input [7:0] A,B;
  input CLK,RST,MODE;
  input [3:0] CMD;
  output reg [7:0] RES = 8'bz;  
  output reg [7:0] Flag = 8'bz;
  
  reg [8:0] temp;  
  
  always @ (posedge CLK)
  begin
  
  if(RST)
  begin
    Flag = 8'bx;    
  end
  
  else
  begin 
  if(MODE)   // 1 for arithmetic block
  begin
    case(CMD)
    4'b0000 :   //add
    begin
            temp = A+B;
            RES = temp[7:0];
            Flag[0] = temp[8];  // carry 
    end
    4'b0001 :   //subtract
    begin
            temp = A-B;
            RES = temp[7:0];
            Flag[0] = temp[8];  // borrow 
    end
    4'b0010 :   //increment A
    begin
        temp = A+1;
        RES=temp[7:0];
        Flag[1]=temp[8];    // overflow flag
    end
    4'b0011 :   //decrement A
    begin
        temp = A-1;
        RES=temp[7:0];
        Flag[2]=temp[8];    // underflow flag
    end        
    4'b0100 :   //increment B
    begin
        temp = B+1;
        RES=temp[7:0];
        Flag[1]=temp[8];    // overflow flag
    end
    4'b0101 :   //decrement B
    begin
        temp = B-1;
        RES=temp[7:0];
        Flag[2]=temp[8];    // underflow flag
    end
    4'b0110 :   //compare
    begin
        RES = A-B;
    end
    default :
    begin
        Flag[7]=1;  // Arithmetic command error
    end
  endcase
  end
  else      // logical block
  begin 
  case(CMD)
    4'b0000 :   //and
        RES=A&B;
    4'b0001 :   //or
        RES=A|B;
    4'b0010 :   //xor
        RES=A^B;
    4'b0011 :   //not A
        RES=~A;
    4'b0100 :   //not B
        RES=~B;
    4'b0101 :   //left shift A
        RES=A<<1;
    4'b0110 :   //right shift A
        RES=A>>1;
    4'b0111 :   //left shift B
        RES=B<<1;
    4'b1000 :   //right shift B
        RES=B>>1;
    default :
    begin
        Flag[6]=1;  // Logical command error
    end
  endcase
  end
  end
  end
    
endmodule
