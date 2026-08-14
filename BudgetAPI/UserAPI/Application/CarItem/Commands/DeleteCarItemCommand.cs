using Microsoft.EntityFrameworkCore;

public class DeleteCarItemCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteCarItemCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }
    public async Task Handle()
    {
        var dbCarItem = await _context.CarItems.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbCarItem is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        _context.CarItems.Remove(dbCarItem);
        await _context.SaveChangesAsync();
    }
}