using System.ComponentModel.DataAnnotations.Schema;

public class Debt
{
    public Debt()
    {
        
    }
    public Debt(decimal? debt_amount,int? user_id/*,int? debtor_id*/,string? debtor_name,bool? isTaken)
    {
        Debt_amount = debt_amount;
        User_id = user_id;
        Debtor_name = debtor_name;
        IsTaken = isTaken;
        // Debtor_id = debtor_id;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    // public int? Debtor_id { get; set; }
    // [ForeignKey("Debtor_id")]
    // public User? Debtor { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public string? Debtor_name { get; set; }
    public decimal? Debt_amount { get; set; }
    public bool? IsPayed { get; set; } = false;
    public bool? IsTaken { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
}