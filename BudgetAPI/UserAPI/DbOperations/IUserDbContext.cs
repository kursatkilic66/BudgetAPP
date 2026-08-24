using Microsoft.EntityFrameworkCore;
public interface IUserDbContext
{
    public DbSet<User> Users {get;set;}
    public DbSet<Car> Cars { get; set; }
    public DbSet<CarItem> CarItems { get; set; }
    public DbSet<Debt> Depts { get; set; }
    public DbSet<FoodOrder> FoodOrders { get; set; }
    public DbSet<FuelOrder> FuelOrders { get; set; }
    public DbSet<OtherCarOrder> OtherCarOrders { get; set; }
    public DbSet<ParkingOrder> ParkingOrders { get; set; }
    public DbSet<PassingOrder> PassingOrders { get; set; }
    public DbSet<TransportationOrder> TransportationOrders { get; set; }
    int SaveChanges();
    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}