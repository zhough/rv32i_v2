`timescale 1ns / 1ps

module core_cpu_tb;

reg cpu_rst, cpu_clk;
initial begin 
    cpu_clk = 1'b0;
    count = 32'b0;
    forever begin
        #5 cpu_clk = ~cpu_clk;
    end
end
initial begin
    cpu_rst = 1;
    #2;
    cpu_rst = 0;
end

wire [12:0] pc_irom;
wire [31:0] dout_irom;
wire [3:0] we;
wire [11:0] dram_addr;
wire [31:0] ram_din, ram_dout;
wire [31:0] irom_addr, irom_data, perip_addr, perip_wdata, perip_rdata;
wire [3:0] perip_mask;
wire perip_en;
wire [31:0] rs3, rs17, rs10, rs2;

assign pc_irom = irom_addr[14:2];
assign irom_data = dout_irom;
assign we = perip_mask;
assign perip_rdata = ram_dout;
assign ram_din = perip_wdata; 
assign dram_addr = perip_addr[13:2];

irom_test u_irom(
    .addra (pc_irom),
    .clka (cpu_clk),
    .douta (dout_irom)
);

blk_mem_gen_1 dram(
    .clka (cpu_clk),
    .ena (1'b1),
    .wea (we),
    .addra (dram_addr),
    .dina (ram_din),
    .douta (ram_dout)
);

core_cpu u_CPU(
    .cpu_rst (cpu_rst),
    .cpu_clk (cpu_clk),
    .irom_addr (irom_addr),
    .irom_data (irom_data),
    .perip_addr (perip_addr),
    .perip_en (perip_en),
    .perip_mask (perip_mask),
    .perip_wdata (perip_wdata),
    .perip_rdata (perip_rdata),
    .rs3 (rs3),
    .rs17 (rs17),
    .rs10 (rs10),
    .rs2 (rs2)
);

reg [31:0] count;
always @(posedge cpu_clk) begin
    if (pc_irom == 13'h1FFF) begin
        $finish;
    end
    count <= count + 1;
    if( (perip_addr >= 32'h80200000) && (perip_addr < 32'h8020FFFF) ) begin
            $display("pc_irom: %h, perip_addr: %h, perip_wdata: %h, perip_rdata: %h, WE: %b, count, %h",
                pc_irom,
                perip_addr,
                perip_wdata,
                perip_rdata,
                perip_mask,
                count
            );
    end
end

endmodule
