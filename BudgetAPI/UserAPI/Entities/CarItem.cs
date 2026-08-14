using System.ComponentModel.DataAnnotations.Schema;

public class CarItem
{
    public CarItem()
    {
        
    }
    public CarItem(string? item_name, int? item_amount, decimal? item_price, string? item_description,int? user_id,int? car_id)
    {
        Item_name = item_name;
        Item_amount = item_amount;
        Item_price = item_price;
        Item_description = item_description;
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
    public string? Item_name { get; set; }
    public int? Item_amount { get; set; }
    public decimal? Item_price { get; set; }
    public string? Item_description { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}