using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/api/[Controller]s")]
public class UserController : ControllerBase
{
    private readonly IUserDbContext _context;

    public UserController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateUserModel model)
    {
        CreateUserCommand vm = new CreateUserCommand(_context,model);
        await vm.Handle();
        return Ok();
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetUserQuery vm = new GetUserQuery(_context,id);
        // await vm.Handle();
        return Ok(await vm.Handle());
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateUserModel model,int id)
    {
        UpdateUserCommand vm = new UpdateUserCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllUsersQuery vm = new GetAllUsersQuery(_context);
        
        return Ok(await vm.Handle());
    }
    [HttpDelete("id")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteUserCommand vm = new DeleteUserCommand(_context,id);
        await vm.Handle();
        return Ok();
    }

    [HttpPut("/activeuser/{id}")]
    public async Task<IActionResult> Active(int id)
    {
        ActiveUserCommand vm = new ActiveUserCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
}