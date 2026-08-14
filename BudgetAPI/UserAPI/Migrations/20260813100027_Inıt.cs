using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace UserAPI.Migrations
{
    /// <inheritdoc />
    public partial class Inıt : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Surname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Cars",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Brand = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Model = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Year = table.Column<int>(type: "int", nullable: true),
                    Kilometer = table.Column<int>(type: "int", nullable: true),
                    TankSize = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cars", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cars_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Depts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Debtor_name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Debt_amount = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    IsPayed = table.Column<bool>(type: "bit", nullable: true),
                    IsTaken = table.Column<bool>(type: "bit", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Depts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Depts_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "FoodOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Food_name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Restaurant = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FoodOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FoodOrders_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "OtherCarOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OtherCarOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OtherCarOrders_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ThemeSetting",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Theme_mode = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Primary_color = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Currency = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Notifications_enabled = table.Column<bool>(type: "bit", nullable: true),
                    Language = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ThemeSetting", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ThemeSetting_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "CarItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Car_id = table.Column<int>(type: "int", nullable: true),
                    Item_name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Item_amount = table.Column<int>(type: "int", nullable: true),
                    Item_price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Item_description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CarItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CarItems_Cars_Car_id",
                        column: x => x.Car_id,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CarItems_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "FuelOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Car_id = table.Column<int>(type: "int", nullable: true),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Unit_price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Total_price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Fuel_liter = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Station = table.Column<int>(type: "int", nullable: true),
                    OrderAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdateAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FuelOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FuelOrders_Cars_Car_id",
                        column: x => x.Car_id,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_FuelOrders_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ParkingOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: false),
                    Car_id = table.Column<int>(type: "int", nullable: false),
                    Parking_name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Total_price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Hour_price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Hour = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Free_hour = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Payment_type = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ParkingOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ParkingOrders_Cars_Car_id",
                        column: x => x.Car_id,
                        principalTable: "Cars",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ParkingOrders_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PassingOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    User_id = table.Column<int>(type: "int", nullable: true),
                    Car_id = table.Column<int>(type: "int", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Payment_type = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PassivedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PassingOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PassingOrders_Cars_Car_id",
                        column: x => x.Car_id,
                        principalTable: "Cars",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PassingOrders_Users_User_id",
                        column: x => x.User_id,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_CarItems_Car_id",
                table: "CarItems",
                column: "Car_id");

            migrationBuilder.CreateIndex(
                name: "IX_CarItems_User_id",
                table: "CarItems",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_Cars_User_id",
                table: "Cars",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_Depts_User_id",
                table: "Depts",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_FoodOrders_User_id",
                table: "FoodOrders",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_FuelOrders_Car_id",
                table: "FuelOrders",
                column: "Car_id");

            migrationBuilder.CreateIndex(
                name: "IX_FuelOrders_User_id",
                table: "FuelOrders",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_OtherCarOrders_User_id",
                table: "OtherCarOrders",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_ParkingOrders_Car_id",
                table: "ParkingOrders",
                column: "Car_id");

            migrationBuilder.CreateIndex(
                name: "IX_ParkingOrders_User_id",
                table: "ParkingOrders",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_PassingOrders_Car_id",
                table: "PassingOrders",
                column: "Car_id");

            migrationBuilder.CreateIndex(
                name: "IX_PassingOrders_User_id",
                table: "PassingOrders",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_ThemeSetting_User_id",
                table: "ThemeSetting",
                column: "User_id",
                unique: true,
                filter: "[User_id] IS NOT NULL");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CarItems");

            migrationBuilder.DropTable(
                name: "Depts");

            migrationBuilder.DropTable(
                name: "FoodOrders");

            migrationBuilder.DropTable(
                name: "FuelOrders");

            migrationBuilder.DropTable(
                name: "OtherCarOrders");

            migrationBuilder.DropTable(
                name: "ParkingOrders");

            migrationBuilder.DropTable(
                name: "PassingOrders");

            migrationBuilder.DropTable(
                name: "ThemeSetting");

            migrationBuilder.DropTable(
                name: "Cars");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
