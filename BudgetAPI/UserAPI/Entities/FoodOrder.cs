using System.ComponentModel.DataAnnotations.Schema;

public class FoodOrder
{
    public FoodOrder()
    {
        
    }
    public FoodOrder(string? food_name, decimal? price, string? restaurant,int? user_id)
    {
        Food_name = food_name;
        Price = price;
        Restaurant = restaurant;
        User_id = user_id;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public string? Food_name { get; set; }
    public decimal? Price { get; set; }
    public string? Restaurant { get; set; }
     public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}