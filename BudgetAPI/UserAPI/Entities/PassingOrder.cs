using System.ComponentModel.DataAnnotations.Schema;

public class PassingOrder
{
    public PassingOrder()
    {
        
    }
    public PassingOrder(string? name, decimal? price, Payment? payment_type)
    {
        Name = name;
        Price = price;
        Payment_type = payment_type;
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
    public Payment? Payment_type { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}