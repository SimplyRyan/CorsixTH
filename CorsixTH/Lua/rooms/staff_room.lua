--[[ Copyright (c) 2009 Peter "Corsix" Cawley

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. --]]

local room = {}
room.name = _S(14, 23)
room.id = "staff_room"
room.class = "StaffRoom"
room.objects_additional = { "extinguisher", "radiator", "plant", "sofa", "pool_table", "tv", "video_game" }
room.objects_needed = { "sofa" }
room.build_cost = 1500
room.build_preview_animation = 5066
room.categories = {
  facilities = 1,
}
room.minimum_size = 4
room.wall_type = "green"
room.floor_tile = 17

class "StaffRoom" (Room)

function StaffRoom:StaffRoom(...)
  self:Room(...)
end

function StaffRoom:onHumanoidEnter(humanoid)
  self.humanoids[humanoid] = true
  self:tryAdvanceQueue()

  if class.is(humanoid, Staff) then
    -- Receptionists cannot enter, so we do not have to worry about them
    humanoid:setNextAction({name = "use_staffroom"})
    self.door.queue.visitor_count = self.door.queue.visitor_count + 1
  else
    -- Other humanoids shouldn't be entering, so don't worry about them
  end
end

return room