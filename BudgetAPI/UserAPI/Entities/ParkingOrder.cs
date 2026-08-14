using System.ComponentModel.DataAnnotations.Schema;

public class ParkingOrder
{
    public ParkingOrder()
    {
        
    }
    public ParkingOrder(string? parking_name, decimal? total_price, decimal? hour_price, decimal? hour, decimal? free_hour, Payment? payment_type)
    {
        Parking_name = parking_name;
        Total_price = total_price;
        Hour_price = hour_price;
        Hour = hour;
        Free_hour = free_hour;
        Payment_type = payment_type;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public int Car_id { get; set; }
    [ForeignKey("Car_id")]
    public Car? Car { get; set; }
    public string? Parking_name { get; set; }
    public decimal? Total_price { get; set; }
    public decimal? Hour_price { get; set; }
    public decimal? Hour { get; set; }
    public decimal? Free_hour { get; set; }
    public Payment? Payment_type { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
    

}