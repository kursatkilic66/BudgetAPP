using System.ComponentModel.DataAnnotations.Schema;

public class Car
{
    public Car()
    {
        
    }
    public Car(string? title, string? brand, string? model, int? year, int? kilometer, int? user_id,int? tank_size)
    {
        Title = title;
        Brand = brand;
        Model = model;
        Year = year;
        Kilometer = kilometer;
        User_id = user_id;
        TankSize = tank_size;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? Owner { get; set; }
    public string? Title { get; set; }
    public string? Brand { get; set; }
    public string? Model { get; set; }
    public int? Year { get; set; }
    public int? Kilometer { get; set; }
    public int? TankSize { get; set; }
    public List<FuelOrder> FuelOrders { get; set; } = new List<FuelOrder>();
    public List<CarItem> CarItems { get; set; } = new List<CarItem>();
    public bool? IsPassived { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}