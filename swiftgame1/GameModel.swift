
import Foundation


//命令，只有点击操作所以只记录坐标
class Command : NSObject{
    var x:Int
    var y:Int
    init (_x:Int,_y:Int){
        x = _x
        y = _y
    }
    init (p:(Int,Int)){
        (self.x,self.y) = p
    }
}

protocol GameModelProtocol {
    func stepadd(step:Int)
    func syndata((Int,Int),val:Int)
    func win(dimension:Int,step:Int)
    func update(dimension:Int)
    func click((Int,Int))
}

//二维数组
struct Matrix<T> {
    
    let rows: Int
    var grid:[T] = []
    init(rows:Int,val:T) {
        self.rows = rows
        grid = Array(count: rows * rows, repeatedValue: val)
    }
    init(rows:Int,fun:()->T) {
        self.rows = rows
        for i in 0...rows*rows {
            grid.append(fun())
        }
        //grid = Array(count: rows * rows, repeatedValue: fun())
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < rows
    }
    subscript(row: Int, col: Int) -> T {
        get {
            assert(indexIsValidForRow(row, column: col), "Index out of range")
            return grid[( row ) * rows + col]
        }
        set {
            assert(indexIsValidForRow(row, column: col), "Index out of range")
            grid[( row ) * rows + col] = newValue
        }
    }
}

//游戏model
class GameModel: NSObject {
    
    //列数 行数
    var dimension: Int
    let delegate: GameModelProtocol
    //步数变化
    var step: Int = 0 {
        didSet {
            delegate.stepadd(step)
        }
    }
    //面板二维数组建模
    var gameboard:Matrix<Int>
    //命令序列最大值
    let maxCommands = 100
    //命令序列
    var queue: [Command]
    var timer: NSTimer
    
    
    init(dimension d: Int ,  delegate :GameModelProtocol) {
        dimension = d
        queue = [Command]()
        timer = NSTimer()
        self.delegate = delegate
        gameboard = Matrix(rows: d,val: -1)
        super.init()
        resetboard(dimension: d)
    }
    
    func resetboard(dimension d: Int){
        gameboard = Matrix(rows: d,val: -1)
    }
    
    /// 重新开始
    func reset() {
        step = 0
        resetboard(dimension:dimension)
        queue.removeAll(keepCapacity: true)
        timer.invalidate()
        delegate.update(dimension)
    }
    /// 用户点击操作
    func click(p:(Int,Int)) {
        if queue.count > maxCommands {
            // Queue is wedged. This should actually never happen in practice.
            return
        }
        let command = Command(p:p)
        queue.append(command)
        if (!timer.valid) {
            // Timer isn't running, so fire the event immediately
            timerFired(timer)
        }
    }
    
    //激活异步程序
    func timerFired(timer: NSTimer) {
        if queue.count == 0 {
            return
        }
        // Go through the queue until a valid command is run or the queue is empty
        var changed = false
        while queue.count > 0 {
            let command = queue[0]
            queue.removeAtIndex(0)
            change(command)
            
        }
    }
    //开始翻转
    func change(command:Command){
        var x = command.x
        var y = command.y
        if(x-1>=0){
            gameboard[x-1,y] *= -1
            delegate.syndata((x-1,y),val:gameboard[x-1,y])
        }
        if(x+1<dimension){
            gameboard[x+1,y] *= -1
            delegate.syndata((x+1,y),val:gameboard[x+1,y])
        }
        if(y-1>=0){
            gameboard[x,y-1] *= -1
            delegate.syndata((x,y-1),val:gameboard[x,y-1])
        }
        if(y+1<dimension){
            gameboard[x,y+1] *= -1
            delegate.syndata((x,y+1),val:gameboard[x,y+1])
        }
        gameboard[x,y] *= -1
        delegate.syndata((x,y),val:gameboard[x,y])
        
        step++
        
        if iswin() {
            
            dimension++
            delegate.win(dimension,step:step)
            reset()
            
        }
    }
    
    //赢了?
    func iswin() -> Bool{
        for i in 0..<dimension {
            for j in 0..<dimension {
                if gameboard[i,j] == -1 {
                    return false
                }
            }
        }
        return true
    }
    
}