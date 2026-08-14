using Microsoft.AspNetCore.Mvc;
using static CreateFoodOrderCommand;
[ApiController]
[Route("/api/[Controller]s")]
public class FoodOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public FoodOrderController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateFoodOrderModel model) 
    {
        CreateFoodOrderCommand vm = new CreateFoodOrderCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateFoodOrderModel model,int id)
    {
        UpdateFoodOrderCommand vm = new UpdateFoodOrderCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteFoodOrderCommand vm = new DeleteFoodOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetFoodOrderQuery vm = new GetFoodOrderQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllFoodOrderQuery vm = new GetAllFoodOrderQuery(_context);
        return Ok(await vm.Handle());
    }
}