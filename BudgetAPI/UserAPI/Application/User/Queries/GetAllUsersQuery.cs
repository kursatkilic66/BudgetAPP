using Microsoft.EntityFrameworkCore;

public class GetAllUsersQuery
{
    private readonly IUserDbContext _context;

    public GetAllUsersQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<User>> Handle()
    {
        return await _context.Users.Include(u=> u.Cars).Include(u=> u.FuelOrders).ToListAsync();
    }
}