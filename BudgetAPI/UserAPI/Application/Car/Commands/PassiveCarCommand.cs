using Microsoft.EntityFrameworkCore;

public class PassiveCarCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public PassiveCarCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }
    public async Task Handle()
    {
        var dbCar = await _context.Cars.FirstOrDefaultAsync(x=> x.Id == _id);
        if(dbCar is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        dbCar.IsPassived = true;
        dbCar.PassivedAt = DateTime.UtcNow;
        _context.Cars.Update(dbCar);
        await _context.SaveChangesAsync();
    }
}