package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	
	public class CubeMovement extends Sprite
	{
		private var view:View3D;
		private var cube:Mesh;
		private var lastX:int;
		private var lastY:int;
		private var isDragging:Boolean = false;
		
		public function CubeMovement()
		{
			// Set up view
			setupView();
			
			// Set up object
			var cubeGeo:CubeGeometry = new CubeGeometry();
			cubeGeo.tile6 = false;			
			cube = new Mesh(cubeGeo);
			view.scene.addChild((cube));
			
			// Star rendering
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		private function update(e:Event):void
		{
			// Render the view
			view.render();
		}
		
		private function setupView():void
		{
			view = new View3D();
			view.backgroundColor = 000000;
			// Position camera
			view.camera.position = new Vector3D(0,0,-700);
			view.camera.lookAt(new Vector3D());
			// Add view to stage
			addChild(view);
		}
		
		private function mouseDown (event:MouseEvent):void{
			isDragging = true;
			lastX = event.stageX;
			lastY = event.stageY;
		}
		
		private function mouseUp (event:Event):void{
			isDragging = false;
		}
		
		private function mouseMove (event:MouseEvent):void{
			
			if(!isDragging)
				return;
			
			var dx:int = lastX - event.stageX;
			var dy:int = lastY - event.stageY;
			
			lastX = event.stageX;
			lastY = event.stageY;
			
			var matrix:Matrix3D = cube.transform;
			
			matrix.appendRotation(dx, new Vector3D(0,0,1));
			matrix.appendRotation(-dy, new Vector3D(1,0,0));
			
			cube.transform = matrix;
		}
	}
}