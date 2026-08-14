using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace UserAPI.Migrations
{
    /// <inheritdoc />
    public partial class OtherCarOrder_carıd_added : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Car_id",
                table: "OtherCarOrders",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_OtherCarOrders_Car_id",
                table: "OtherCarOrders",
                column: "Car_id");

            migrationBuilder.AddForeignKey(
                name: "FK_OtherCarOrders_Cars_Car_id",
                table: "OtherCarOrders",
                column: "Car_id",
                principalTable: "Cars",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_OtherCarOrders_Cars_Car_id",
                table: "OtherCarOrders");

            migrationBuilder.DropIndex(
                name: "IX_OtherCarOrders_Car_id",
                table: "OtherCarOrders");

            migrationBuilder.DropColumn(
                name: "Car_id",
                table: "OtherCarOrders");
        }
    }
}
