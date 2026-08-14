using System.ComponentModel.DataAnnotations.Schema;

public class OtherCarOrder{
    public OtherCarOrder()
    {
        
    }
    public OtherCarOrder(string? name, decimal? price,int? user_id,int? car_id)
    {
        Name = name;
        Price = price;
        User_id = user_id;
        Car_id = car_id;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public int? Car_id { get; set; }
    [ForeignKey("Car_id")]
    public Car? Car { get; set; }
    public string? Name { get; set; }
    public decimal? Price { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}