using System.ComponentModel.DataAnnotations.Schema;

public class TransportationOrder
{
    public TransportationOrder()
    {
        
    }
    public TransportationOrder(string name, decimal amount, DateTime createdAt, DateTime updatedAt)
    {
        Name = name;
        Amount = amount;
        CreatedAt = createdAt;
        UpdatedAt = updatedAt;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User;
    public string? Name { get; set; }
    public decimal? Amount { get; set; }
    public DateTime? CreatedAt = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
}