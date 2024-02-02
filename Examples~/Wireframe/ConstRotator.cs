using UnityEngine;
using System.Collections;

public class ConstRotator : MonoBehaviour {
	public Vector3 speed;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.rotation *= Quaternion.Euler(Time.deltaTime * speed);

	}
}
