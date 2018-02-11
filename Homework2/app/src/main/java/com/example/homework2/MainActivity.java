package com.example.homework2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Spinner;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;
import android.view.View;
import android.view.View.OnClickListener;
import android.content.Intent;
import java.util.*;
import android.net.Uri;

public class MainActivity extends AppCompatActivity {

    private Spinner spinner1;
    private Button button;
    private TextView textView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //ArrayAdapter adapter = ArrayAdapter.createFromResource(this, R.array.intents, android.R.layout.simple_spinner_item);
        //adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        //spinner.setAdapter(adapter);
        //onClick(spinner);
        itemSpinner();
        buttonListener();
    }
    /*public void onClick(View view)
    {
        int position = spinner1.getSelectedItemPosition();
        Intent intent = null;

        switch(position)
        {
            case 0:
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse("Binary Search Tree"));
                break;
            case 1:
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse("Linked List"));
                break;
        }
        if(intent != null)
        {
            startActivity(intent);
        }

    }*/

    public void itemSpinner()
    {
        spinner1 = findViewById(R.id.spinner);
        ArrayList<String> list = new ArrayList<>();
        list.add("Binary Search Tree");
        list.add("Linked List");
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, list);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner1.setAdapter(dataAdapter);
    }
    public void buttonListener()
    {
        spinner1 = findViewById(R.id.spinner);
        button = findViewById(R.id.emailButton);

        button.setOnClickListener(new OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                textView = findViewById(R.id.textView17);
                textView.setText(spinner1.getSelectedItem().toString());
            }
        });
    }
}
