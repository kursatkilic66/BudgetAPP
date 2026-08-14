using Microsoft.EntityFrameworkCore;

public class GetUserQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetUserQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }
    public async Task<User> Handle()
    {
        var dbUser = await _context.Users.Include(u => u.Cars).Include(u => u.FuelOrders).FirstOrDefaultAsync(x=> x.Id == _id);
        if(dbUser is null)
        {
            throw new InvalidOperationException("Kullanıcı mevcut değil!");
        }
        // Task<GetUserModel> OLARAK DEĞİŞTİR DTO YU AKTIFLESTIRINCE
        // var model = new GetUserModel();
        // model.Name = dbUser.Name;
        // model.Surname = dbUser.Surname;
        // model.Email = dbUser.Email;
        // return model;       
        return dbUser; 
    }
}

public class GetUserModel
{ public GetUserModel()
{
    
}
    public GetUserModel(string? name, string? surname, string? email)
    {
        Name = name;
        Surname = surname;
        Email = email;
    }

    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? Email { get; set; }
}