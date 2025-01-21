pub fn CircularBuffer(comptime T: type, comptime size: usize) type {
    return struct {
        buffer: [size]T = undefined,
        buffer_start: usize = 0,
        item_count: usize = 0,
        write_in_progress: bool = false,

        pub fn init() @This() {
            return .{ };
        }

        pub fn getCurrentWritePosition(this: *@This()) usize {
            return (this.buffer_start + this.item_count) % size;
        }

        pub fn getCurrentWriteItem(this: *@This()) *T {
            return &this.buffer[this.getCurrentWritePosition()];
        }

        pub fn beginWrite(this: *@This()) !*T {
            if(this.write_in_progress){
                return error.WriteAlreadyInProgress;
            }
            this.write_in_progress = true;
            return this.getCurrentWriteItem();
        }

        pub fn endWrite(this: *@This()) !void {
            if(!this.write_in_progress){
                return error.WriteNotInProgress;
            }
            this.write_in_progress = false;
            this.item_count += 1;
        }

        pub fn advanceWritePosition(this: *@This()) !void {
            if(this.item_count > size){
                return error.BufferIsFull;
            }
            this.item_count += 1;
        }

        pub fn pop(this: *@This()) ?*T {
            if(this.item_count == 0){
                return null;
            }
            this.item_count -= 1;
            this.buffer_start += 1;
            return &this.buffer[(this.buffer_start - 1) % size];
        }

    };
}