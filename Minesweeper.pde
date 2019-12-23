import de.bezier.guido.*;
public final int NUM_ROWS = 30; //NUM_ROWS = 20;
public final int NUM_COLS = 30; //NUM_COLS = 20;
public final int NUM_BOMBS = 1;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> ();; //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(600, 600); //size(400,400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0 ; r < NUM_ROWS ; r++){
    	for(int c = 0; c < NUM_COLS ; c++){
    		buttons[r][c] = new MSButton(r , c);
    	}
    }
    
    
    setBombs();
}
public void setBombs()
{	
	while(bombs.size() < 100){
    	int r = (int)(Math.random() * NUM_ROWS);
    	int c = (int)(Math.random() * NUM_COLS);
    	if(!(bombs.contains(buttons[r][c]))){
    		bombs.add(buttons[r][c]);
    		//System.out.println("("+ r + ", " + c + ")");
    	}
	}
	while(bombs.size() < 100){
		int r2 = (int)(Math.random() * NUM_ROWS);
    	int c2 = (int)(Math.random() * NUM_COLS);
    	if(!(bombs.contains(buttons[r2][c2]))){
    		bombs.add(buttons[r2][c2]);
    		//System.out.println("("+ r2 + ", " + c2 + ")");
    	}
	}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    fill(0,0,0);
    textSize(15);
    text("YOU LOSE",29 , 29);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS; //400/NUM_COLS
        height = 600/NUM_ROWS; //400/NUM_ROWS
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
        	if(!marked){
        		marked = true;
        	}
        	else if(marked){
        		marked = false;
        	}
        	if(!marked){
        		clicked = false;
        	}
        }
        else if(bombs.contains(this)){
        	displayLosingMessage();
        }
        else if(countBombs(r,c) > 0){
        	label = "" + countBombs(r , c);
        	
        }
        else{
            
        		 if(isValid(r, c -1) && (buttons[r][c - 1].isClicked() == false)){
        			buttons[r ][c - 1].mousePressed();
              
        		}
        		 if(isValid(r, c + 1) && (buttons[r][c + 1].isClicked() == false)){
        			buttons[r ][c + 1].mousePressed();
              
        		}
        		 if(isValid(r + 1, c) && (buttons[r+1][c].isClicked() == false)){
        			buttons[r + 1][c].mousePressed();
              
        		}
        		if(isValid(r - 1, c) && (buttons[r - 1][c].isClicked() == false)){
        			buttons[r - 1][c].mousePressed();
              
        		}
        		if(isValid(r - 1, c - 1) && (buttons[r - 1][c].isClicked() == false)){
        			buttons[r - 1][c - 1].mousePressed();
              
        		}
        		if(isValid(r + 1, c + 1) && (buttons[r + 1][c + 1].isClicked() == false)){
        			buttons[r + 1][c + 1].mousePressed();
              
        		}
        		if(isValid(r - 1, c + 1) && buttons[r - 1][c + 1].isClicked() == false){
        			buttons[r - 1][c + 1].mousePressed();
              
        		}
        		if(isValid(r + 1, c -1) && buttons[r + 1][c - 1].isClicked() == false){
        			buttons[r + 1][c - 1].mousePressed();       
        		}
        }
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 10,100,0 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        return (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0);
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i = -1; i <= 1; i++ ){
        	for(int j = -1; j <=1; j++){
        		if(isValid(row + i, col + j)){
        			if(bombs.contains(buttons[row + i][j + col])){
        				numBombs++;
        			}
        		}
        	}
        }
        if(bombs.contains(buttons[row][col])){
        	numBombs--;
        }
        return numBombs;
    }
}
 
