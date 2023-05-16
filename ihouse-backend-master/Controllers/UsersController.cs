﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ihouse.Database;
using ihouse.Models;

namespace ihouse_backend.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  public class UsersController : ControllerBase
  {
    private readonly UserContext _context;

    public UsersController(UserContext context)
    {
      _context = context;
    }

    // GET: api/Users
    [HttpGet, HttpOptions]
    public ActionResult<String> GetUsers()
    {
      if (_context.Users == null)
      {
        return NotFound();
      }
      return "aaaa";
    }

    // GET: api/Users/5
    [HttpGet("{email}")]
    public async Task<ActionResult<User>> GetUser(string email)
    {
      if (_context.Users == null)
      {
        return NotFound();
      }
      var users = await _context.Users.ToListAsync();
      User? user = null;
      foreach (User u in users)
      {
        if (u.Email == email)
        {
          user = u; break;
        }
      }

      if (user == null)
      {
        return NotFound();
      }

      return user;
    }

    // PUT: api/Users/5
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPut("{id}")]
    public async Task<IActionResult> PutUser(int id, User user)
    {
      if (id != user.Id)
      {
        return BadRequest();
      }

      _context.Entry(user).State = EntityState.Modified;

      try
      {
        await _context.SaveChangesAsync();
      }
      catch (DbUpdateConcurrencyException)
      {
        if (!UserExists(id))
        {
          return NotFound();
        }
        else
        {
          throw;
        }
      }

      return NoContent();
    }

    // POST: api/Users
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPost]
    public async Task<ActionResult<User>> PostUser(User user)
    {
      if (_context.Users == null)
      {
        return Problem("Entity set 'UserContext.Users'  is null.");
      }
      _context.Users.Add(user);
      await _context.SaveChangesAsync();

      return CreatedAtAction("GetUser", new { id = user.Id }, user);
    }

    // DELETE: api/Users/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
      if (_context.Users == null)
      {
        return NotFound();
      }
      var user = await _context.Users.FindAsync(id);
      if (user == null)
      {
        return NotFound();
      }

      _context.Users.Remove(user);
      await _context.SaveChangesAsync();

      return NoContent();
    }

    private bool UserExists(int id)
    {
      return (_context.Users?.Any(e => e.Id == id)).GetValueOrDefault();
    }
  }
}