using System.ComponentModel.DataAnnotations.Schema;

public class User
{
    public User()
    {
        
    }
    
    public User(string name, string surname, string email, string password)
    {
        Name = name;
        Surname = surname;
        Email = email;
        Password = password;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? Email { get; set; }
    public string? Password { get; set; }
    public List<Car> Cars { get; set; } = new List<Car>();
    public List<FuelOrder> FuelOrders { get; set; } = new List<FuelOrder>();
    public List<ParkingOrder> ParkingOrders { get; set; } = new List<ParkingOrder>();
    public List<PassingOrder> PassingOrders { get; set; }= new List<PassingOrder>();
    public List<FoodOrder> FoodOrders { get; set; }= new List<FoodOrder>();
    public List<OtherCarOrder> OtherCarOrders { get; set; }= new List<OtherCarOrder>();
    public List<Debt> Debts { get; set; }= new List<Debt>();
    public ThemeSetting? Settings { get; set; }
    public bool? IsPassived { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? PassivedAt { get; set; }
    public DateTime? LastUpdate { get; set; }

}