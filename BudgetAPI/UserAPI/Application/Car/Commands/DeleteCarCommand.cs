using Microsoft.EntityFrameworkCore;

public class DeleteCarCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteCarCommand(IUserDbContext context, int id)
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
        _context.Cars.Remove(dbCar);        
        await _context.SaveChangesAsync();
    }
}