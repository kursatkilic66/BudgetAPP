using System.ComponentModel.DataAnnotations.Schema;

public class FuelOrder
{
    public FuelOrder()
    {
        
    }

    public FuelOrder(decimal? unit_price, decimal? total_price, decimal? fuel_liter, GasStation? station)
    {
        Unit_price = unit_price;
        Total_price = total_price;
        Fuel_liter = fuel_liter;
        Station = station;
    }


    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int? Car_id { get; set; }
    [ForeignKey("Car_id")]
    public Car? Car { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public decimal? Unit_price { get; set; }
    public decimal? Total_price { get; set; }
    public decimal? Fuel_liter { get; set; }
    public GasStation? Station { get; set; }
    public DateTime OrderAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdateAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}