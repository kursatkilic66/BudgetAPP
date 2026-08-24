using Microsoft.EntityFrameworkCore;

public class UserDbContext : DbContext,IUserDbContext
{
    public UserDbContext(DbContextOptions<UserDbContext> options) : base(options)
    {
        
    }

    public DbSet<User> Users { get; set; }
    public DbSet<Car> Cars { get; set; }
    public DbSet<CarItem> CarItems { get; set; }
    public DbSet<Debt> Depts { get; set; }
    public DbSet<FoodOrder> FoodOrders { get; set; }
    public DbSet<FuelOrder> FuelOrders { get; set; }
    public DbSet<OtherCarOrder> OtherCarOrders { get; set; }
    public DbSet<ParkingOrder> ParkingOrders { get; set; }
    public DbSet<PassingOrder> PassingOrders { get; set; }
    public DbSet<TransportationOrder> TransportationOrders { get; set; }

    public override int SaveChanges()
    {
        return base.SaveChanges();
    }
    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken= default)
    {
        return base.SaveChangesAsync();
    }
}   
